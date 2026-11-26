# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT82 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.1.tgz"
  sha256 "a9f092ae84f32f15149a09a9a278bb20d3794cbfb57893eab4933814d7ab2fd5"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "c832ae6587f885a57c3c61cd33ad26b72081647347b4db2719fc9420da7de5d4"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "3d1a7671a34a32528603aff5d01f6b5478663bd7d8843cce25faf33532d4fda1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "fde42d2c6433032a86e396793036a6b66358f4a31fd96040d0a505ec9ed621df"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "447cd958d5aa70b72092a180fbff9e1a009b5e800495c98436b9ee99aba26b7e"
    sha256 cellar: :any,                 arm64_linux:       "9d84311bb36e0b5e90e09b74f993916e98a2392b1a89233b76d7535b7f0c375f"
    sha256 cellar: :any,                 x86_64_linux:      "de5829fd648ea23c043a2880c8ce40e47d7be5110a7d5f4c6b29a1206b853e62"
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
