# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT80 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "deb42b9fae9402173b31b9444e5959424f2d6d49bedec816d51a5baa9db3a2c5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2eb746b69387c1c9f7698240b9db8571c3c31a3ee544dfb9cd92c022837c7b56"
    sha256 cellar: :any_skip_relocation, ventura:        "b00e38a4ad1516d7ddbdf0641bd1e197ce287c4715e650364c104ca1b4f4d456"
    sha256 cellar: :any_skip_relocation, monterey:       "7dc127be3d172bc09c42b60d250abf801e55aa5f4a262f6bda6a89dad1f18820"
    sha256 cellar: :any_skip_relocation, big_sur:        "0dc7acb42f2bb5376562f4b3b699f0c4b9e0a123ad8fce62d9ce8b1c4aaf4f5b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0829d4d3ef08a2ad3b47df3c8036687fa2815991d0d62348db0f0afc4a870536"
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
