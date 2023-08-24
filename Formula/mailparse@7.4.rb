# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT74 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3c3a2fd040992ff57c46205ef058eb68bd1aebef8504a6658f9a07d001495714"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9f12348ba0f93ade8e5f7bdb18d77255c976652f06c4db1ea4e372d416b38f25"
    sha256 cellar: :any_skip_relocation, ventura:        "0f4ce1cd7212b830d8f7dd36df58d984963d6aea2b13ff5a5801335e944ebc86"
    sha256 cellar: :any_skip_relocation, monterey:       "8f93f77b747bb7c6c62c57975b25b9e2cb366a09743c8eb89a5c48a59013d498"
    sha256 cellar: :any_skip_relocation, big_sur:        "d8a745416bc0aa3db1d9b23dc9960ab5cde355665b27c0c130fcd6f1c66c41ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ebe40500714117df7cabc9093a0d6710c957918b60a9dc6c9aa7920c25c7c441"
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
