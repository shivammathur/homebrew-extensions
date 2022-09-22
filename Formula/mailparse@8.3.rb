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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fa005a0dfdf5f66036a0d524378ee317a91b3c7024fd5b310ebb28f5d34365d7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "56f4f29f5d3b7a2ad5b6cddb2b2f786013a38d62f42016e579c7ec6433e22989"
    sha256 cellar: :any_skip_relocation, monterey:       "c732638717de46897f5932c31b26ee85898c954a5bdea726b57c338e195f94d1"
    sha256 cellar: :any_skip_relocation, big_sur:        "578269ec815dba5f435e439fd04b4adce1b3abdf1d52a2fa5dbb6b9cf9d3b2cb"
    sha256 cellar: :any_skip_relocation, catalina:       "280ca7ed7ecc7c3b0ee50383463c0f0cb74dd3e8269b58d10b455dea3de29273"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "57e61d0c32b5d51436321eba2afdbaa5b12bbab5dc818eacd13beeb2214553a8"
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
