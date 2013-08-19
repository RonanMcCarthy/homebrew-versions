require 'formula'

class Hadoop0202 < Formula
  url 'http://archive.apache.org/dist/hadoop/common/hadoop-0.20.2/hadoop-0.20.2.tar.gz'
  homepage 'http://hadoop.apache.org/'
  md5 '8f40198ed18bef28aeea1401ec536cb9'
  version '0.20.2'

  def shim_script target
    <<-EOS.undent
    #!/bin/bash
    exec #{libexec}/bin/#{target} $*
    EOS
  end

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install %w[bin conf contrib lib webapps]
    libexec.install Dir['*.jar']
    bin.mkpath
    Dir["#{libexec}/bin/*"].each do |b|
      n = Pathname.new(b).basename
      (bin+n).write shim_script(n)
    end
  end

  def caveats
    <<-EOS.undent
      $JAVA_HOME must be set for Hadoop commands to work.
    EOS
  end
end
