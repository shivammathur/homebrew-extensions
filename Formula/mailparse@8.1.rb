# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT81 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "0166e11a099ddac8251e591460dd66528fd7143d6e9b0622571f8c7672509d36"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9856d57cc01af6cf4945a262d47d7be500cc7964739de21108d1945137979af4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "db4eaf117c4ab70908c39f5c5f74e2def9a72437821cd2b2829fd5367ecd4c5b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "79dad04edc6e4b126183769003325d135f0fbf4f180213ff5aeb3e632c02267e"
    sha256 cellar: :any_skip_relocation, ventura:        "65a072f268619d504177a73f2a0da000021799c4431ce98fe5d987d5b448e2fc"
    sha256 cellar: :any_skip_relocation, monterey:       "605c8c5dc799ef9ba0ee0fe718146388573ef8fca9fe3dfe3e32695269d8f1b1"
    sha256 cellar: :any_skip_relocation, big_sur:        "ae86618d299f6c02e59158b1fa41405e4a072e2b7abd73d2e2a9c990a4b06f9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "83afe221cab80c430adf13fdc3b9afdf374cf28cdd1ebf09636139075629019d"
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
