# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT83 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.4.tgz"
  sha256 "1474921b32c7eef825144e2be19b1e9d47505ad409729833fd50c25eacdf9577"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7aec0fbf3b061534ea232e7d9d22ff303feceb674ac220ef60a80ce42cea5b40"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d3671ad9a81f204bc1bfb7fccc157db680550674ee52aad22096dd999c1eb8f3"
    sha256 cellar: :any_skip_relocation, monterey:       "75756bf34cd3dd97e5c7021ac63f2e4536c0645574f1c52e19ff8c7d4db77f34"
    sha256 cellar: :any_skip_relocation, big_sur:        "c527d422155b8831d29a9a46fb1ed060b1777cc3e82486566a349a5e188f8a99"
    sha256 cellar: :any_skip_relocation, catalina:       "bd27911d61d953bd4ba83bccfbe018935a4b3811f67db66cbde561f264393449"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c622247ff718e041bd39b4860b1c89ba6111845feae6f55826beafffaee04470"
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
