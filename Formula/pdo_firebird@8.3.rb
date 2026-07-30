# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT83 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.33.tar.xz"
  sha256 "e293ed620cec74651bb4a071317892a478aa6840fab22db45c72d77cd42f9676"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "b398a9ba6dcf18785f6527b76abab33e729dab87ab0d5119e2da7d6505549ea2"
    sha256 cellar: :any, arm64_sequoia: "1ac4430fa37c63f43cd2fcb6f6e61b945c45d57216f4d5697e8662418d368dc8"
    sha256 cellar: :any, arm64_sonoma:  "a6b594546be58367bce61f3c1b951566a5b2df4dd2d8145965d8fc87defbad3c"
    sha256 cellar: :any, sonoma:        "cc6a93eecb03f87116c5cb6d44b3a185b0809cce843ed7efec27d275b347c059"
    sha256 cellar: :any, arm64_linux:   "d29df9d9c8689ef4d005395d16790fb886f9070fab66a61774b8aa7fe6e32d92"
    sha256 cellar: :any, x86_64_linux:  "85b1bed04472c68ba060e6bfc130631f9c253ebe17c44093e5ae3e41a68425bd"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
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
