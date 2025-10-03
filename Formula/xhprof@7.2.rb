# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT72 < AbstractPhpExtension
  init
  desc "Hierarchical Profiler for PHP"
  homepage "https://github.com/longxinH/xhprof"
  url "https://pecl.php.net/get/xhprof-2.3.10.tgz"
  sha256 "251aee99c2726ebc6126e1ff0bb2db6e2d5fd22056aa335e84db9f1055d59d95"
  license "Apache-2.0"

  def install
    Dir.chdir "xhprof-#{version}" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig
      system "make"
      prefix.install "modules/#{extension}.so"
    end
    write_config_file
  end
end
