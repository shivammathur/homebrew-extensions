# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT82 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.5.tgz"
  sha256 "34c685c102a6b57a3f516e9d8fc8ef786bd191c321d0f5d1d3764c1f1ee20620"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3014452ad941068b1c3ef90408511d7075cac424a034a4e74b6abe60856783b2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "98ae41afdca5f257d273b7082b778c1030dc8bfcb100a53be39e13255646909c"
    sha256 cellar: :any_skip_relocation, ventura:        "37c59dbe3879ff4272a47be906d07b89937320c3a61880093c0009624135d49d"
    sha256 cellar: :any_skip_relocation, monterey:       "21784743703ed3c299b11a22f933a49241ef5c1fbd47ff616466703a89144927"
    sha256 cellar: :any_skip_relocation, big_sur:        "893f9b127b92e64077536962b978ad226721162c00fbdb84ed438bd2505938d7"
    sha256 cellar: :any_skip_relocation, catalina:       "eda719691ffa1737d13f8a882435ec95f349a073299c8b16b75c63564c0cd99f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0554f668ddd2cc1d494fc4f35d5955f5bd6eca0e0e887025120ceca82b14134d"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
