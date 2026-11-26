# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT83 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.1.tgz"
  sha256 "b280d9e9c146586648b0d4c14720220b9e1aaa1a3083a31ab1665784c90601d0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "091c4b6c149508034308c7aafd4e5d28b8d8d91556fe104978339fd7a9731308"
    sha256 cellar: :any, arm64_golden_gate: "a86301211dfc95c5d391993e0ab50d43ac011fc783f965dbeda73834f57cc2e4"
    sha256 cellar: :any, arm64_tahoe:       "d3627e35a6eb961301d8285a2849359489e8f341e448d68d57fab11632482846"
    sha256 cellar: :any, arm64_sequoia:     "33e4b9a3a1d4c69ee729390040ba4908c3bc79e5d804a53b3c23a1afa763343d"
    sha256 cellar: :any, arm64_linux:       "01b3e9a707422e256e1f674cbc419ca355a398c60593d24879a1871a89c4db70"
    sha256 cellar: :any, x86_64_linux:      "ddf2959830f7f3f18b7e05a7c8963e6fb74c5f9954b1b17cdcdcbe5bae5a4a4e"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
