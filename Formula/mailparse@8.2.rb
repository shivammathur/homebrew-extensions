# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT82 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.3.tgz"
  sha256 "8659ca62dc9a4d7d15f07f97a0e2142cb58251c8e772cd36669ec740d2292471"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "972462a33a2f9ba74bbedfddb706c9d7645a606be05280012b6b28e777ca9ad0"
    sha256 cellar: :any_skip_relocation, big_sur:       "30c36141bbe171455a42e4d77a1211d07a34a9fea05975b8f2db98285d559de2"
    sha256 cellar: :any_skip_relocation, catalina:      "365a74647136d03e01afee04fa1c8c3c4b292f2700e332378d3c8737ae12376f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "94f2d5c460ff30ed7397c0f54e2ab109091f3b8a5858ee38bf02cfbc48bec826"
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
