# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c8ba63777f0e690351b3cff8dfe59aae3056171027b63199d9d426d0dde09a19"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5f60188e1ec07094b68cee0b9d4167c39ca8ee9d2bad5ab539846e03bbeae950"
    sha256 cellar: :any_skip_relocation, monterey:       "0d46ff7a1d053eab5c4d0bdda25d5e9ac3ed765aca3367cc8b7b8ab124985fb8"
    sha256 cellar: :any_skip_relocation, big_sur:        "e4baa7f93103b9abb394c954f3c20141c56fa4d82e1182d665a4543aaa9dcae2"
    sha256 cellar: :any_skip_relocation, catalina:       "ba196fee651a91b23e7df2fb49acfc6f19846856f3b66c4cfbefedcd0249b532"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c6bd18ec61311ec4bba3e0246e638cb352d40e6340c6624575ee6fc64aee3550"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
