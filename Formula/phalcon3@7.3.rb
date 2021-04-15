require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon3AT73 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v3.4.5.tar.gz"
  sha256 "4c56420641a4a12f95e93e65a107aba8ef793817da57a4c29346c012faf66777"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e8b71f9583bf4b304ca9068e537541a8bd4444f227360359d6a9dc6bf0a8b315"
    sha256 cellar: :any_skip_relocation, big_sur:       "9e65dd0130de5776faaacf4cfb706bd9b3ac99d4ce56ae6536b438d1d7790a89"
    sha256 cellar: :any_skip_relocation, catalina:      "90ffa28c83344eb16333970eb73e574eda758390abe232eda9517b0fef06e547"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.3"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
