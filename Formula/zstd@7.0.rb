# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT70 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.0.tgz"
  sha256 "46592a6576c2f42927659dd00dc6c3f39f1fcae7374e95e1f4e11f8ce4f477fc"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "25aab9c129e2334d97bd12363a6aca672fad37ffcc76af2f51727ae55b35a185"
    sha256 cellar: :any, arm64_golden_gate: "d02bb362b163c1b829c3b2c35352ce4435e1489c20e993a8a83beb77b5849742"
    sha256 cellar: :any, arm64_tahoe:       "29a92c0fa8d6ea82264e29b719fc6498d20823fc6ab24a49ec2446ed022603a7"
    sha256 cellar: :any, arm64_sequoia:     "28ec8277f4b39c310b89ac94c5554fa6e550e8cb13c65f236ba3547b787ab1ce"
    sha256 cellar: :any, arm64_linux:       "53f41270693c64a0c79ec3abbdc9c1b3dd82fa2669203faafe3a74429bf8edbd"
    sha256 cellar: :any, x86_64_linux:      "9eb956bb883e2b7b655f9d6c8b9ae9cb96131a468fa3e2de3cb6f6daf2738d3c"
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
