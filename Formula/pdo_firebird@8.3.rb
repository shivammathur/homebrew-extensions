# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT83 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "455d23364ecf0c7077240a1a6c78bf53f72f2eadf8d9775d790d8f54ba8a0eb2"
    sha256 cellar: :any,                 arm64_sequoia: "080f076d668ac9fa6e3ca84dc3579f70d827d60f2563cfce29fb5830a39ce43f"
    sha256 cellar: :any,                 arm64_sonoma:  "13841b0f27fded70e8a2fdaf1b815cd42c4ad3ce039e6c260590ce24070fe4b6"
    sha256 cellar: :any,                 sonoma:        "06f1b2c3a43669da22709f23543cc94614fb40c9aff316fdf2e49abc151c0577"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cb674389b24cd2ec23667fdd0e587ccd0d2442cc340a13c8af1ae0b488325e22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8ab47699e00be4eeadea66758971987d20e6e50fccc909709fe178c4d31477ea"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.30.tar.xz"
  sha256 "67f084d36852daab6809561a7c8023d130ca07fc6af8fb040684dd1414934d48"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end
  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
