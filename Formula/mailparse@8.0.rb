# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT80 < AbstractPhpExtension
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
    manifest_sha256 "600902f45c834ac95c93f6067e78317304e39860ce84f25fe4ba5edd49b94fef"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b7adc0d38f5da8b5feef887724921af1d068320532c60560feda2f09c9c59238"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "acf4329766b6e90e448a3db99a9bbbde6c63662d5d13632bf5f4478bff9093a5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "0ddcc170e73406cebadf9f09ec786d076ded58ef5c4237c839ece2e55601965a"
    sha256 cellar: :any,                 arm64_linux:       "b3ee732f6d27ec8c6db5e7e347e39ccdd554d8066747df0e344f36c3540f4436"
    sha256 cellar: :any,                 x86_64_linux:      "325b204ca27bd467870ed9f5ec8819c4460e63ee04d49560002db639e397079a"
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
