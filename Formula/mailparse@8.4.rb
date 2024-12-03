# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT84 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "936f55c5ea4bdf50cd6f4a416c99eafb84e2d6151ddc82b49e676031a82446b3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e0703caf5247662e4473fa5365eabc7daeb079a4470036b60086cc2c19660b6e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "76b5b45174a52cf0e0ad60ebe0c583693ea9a3e4e3515c244da5cb63874107a5"
    sha256 cellar: :any_skip_relocation, ventura:       "38379a1e145bd8afeb3f9f4b3fb8ad01d9e9e2dd723ff2bff4d92332174e33ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "90153f3209d71ac65eafa3143b7596e567336a3e66454fc30d6f6524ba63d0d8"
  end

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
