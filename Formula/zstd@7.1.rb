# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT71 < AbstractPhpExtension
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
    manifest_sha256 "840adaf5929c9dbb8d6520f28df46b1198612d126e54c456bd3ad019f4727d37"
    sha256 cellar: :any, arm64_golden_gate: "591c28fdfd873a35a0587d12a1f67b55ffd4cef704725b4ca0bcc23c619e2187"
    sha256 cellar: :any, arm64_tahoe:       "243cb20f444ffec5a0d4103b95511caea378c9a0c2437608ef37dad65bdb8f44"
    sha256 cellar: :any, arm64_sequoia:     "a0ae02103521f82752b4d5015600f3f3cbb0ff8b211813689f9bcd3016dfea1a"
    sha256 cellar: :any, arm64_linux:       "a5c01d9d3b0c929b910589e07abfd71dd119e6589e11e92b2ebe60d19eaa5bab"
    sha256 cellar: :any, x86_64_linux:      "ee17d2dd12efc224874d89fe196f659f422e1fd9a81f99b9ef782f479e1e8077"
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
