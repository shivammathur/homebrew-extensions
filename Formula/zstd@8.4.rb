# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT84 < AbstractPhpExtension
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
    manifest_sha256 "1c89a1c223f3e95065bd82a08a3949f22c2a31eaf0800c08edbab5ef4fc059fe"
    sha256 cellar: :any, arm64_golden_gate: "6e01ba7e7a97e5af006f0cc0998c197f5cc2b7abed499effa42a7368660ddb4e"
    sha256 cellar: :any, arm64_tahoe:       "0a09fe38665b82744b67d3b2e1b2325f30c6b0c220bc888e00f10bc3939a72b2"
    sha256 cellar: :any, arm64_sequoia:     "6e1c07598a678282a6a3d8748ad4bc07d80f22edbb47b2b1711a0d730428f367"
    sha256 cellar: :any, arm64_linux:       "72734e698b3d3b4f2ca5da366ac5f2ac3b9605d0c9442e11dda8a83aafcbfdb1"
    sha256 cellar: :any, x86_64_linux:      "ecdfd34c1a45b4ab69e200c0c86f34f3c99a127a53298001c493dc090f91f715"
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
