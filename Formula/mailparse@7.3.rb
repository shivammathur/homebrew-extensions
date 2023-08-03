# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT73 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.5.tgz"
  sha256 "34c685c102a6b57a3f516e9d8fc8ef786bd191c321d0f5d1d3764c1f1ee20620"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "395176a90d34c99f8d15de2c2319c777b1e30018efbd09d7af201db08c9dc9c1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "31460d0dfa3e8222df2ed4245853f29a778ca7fc7091e7aeecaa29d5a103abe3"
    sha256 cellar: :any_skip_relocation, ventura:        "db05be769cece6a591a53fd1231bbd69a506905b7a7024946be884e825d0d7cb"
    sha256 cellar: :any_skip_relocation, monterey:       "9901e3e1ae2d4bd836de0bcc0b6fa80b0d0a95758eb6b7e9e20a7b650aba147d"
    sha256 cellar: :any_skip_relocation, big_sur:        "3607556c29d1b6f496e1e063a1522925141abb698eb852e69fe3974b03df7667"
    sha256 cellar: :any_skip_relocation, catalina:       "f59f91f2d4c9e950155983b12033aa2066d3b050bdd9857205d2efa957d776e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a3021f3d948234e6dc90792e88596bcee033c83d69b7670f525b2a7ee4229bd7"
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
