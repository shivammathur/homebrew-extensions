# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT80 < AbstractPhpExtension
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
    manifest_sha256 "c338e81afbd4bfc49cbbebc7c67d398c9a2118ebcb63bf2c7e5546668ed2a94a"
    sha256 cellar: :any, arm64_golden_gate: "478dd6cb06f0a140b2b32bc723f8aaa05003f2fea732fc03aabab5c71e91c2c5"
    sha256 cellar: :any, arm64_tahoe:       "36ad33912169f3dae31efa285fd1280c17c986ed6a087151d5da57ecea57f897"
    sha256 cellar: :any, arm64_sequoia:     "960adc4d6edf943a7bbc9528c70c0b305c0873b80323509b2bd203808714be2e"
    sha256 cellar: :any, arm64_linux:       "93b8102787fceddb6771c93b5d87fbf742395d33fd1d390a072708834977ef58"
    sha256 cellar: :any, x86_64_linux:      "193f80be619025a642a1d5a235f1d54835490e81780a2d56924e67e9e6f6d13c"
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
