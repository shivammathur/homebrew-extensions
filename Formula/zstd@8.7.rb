# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT87 < AbstractPhpExtension
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
    manifest_sha256 "77b0ba747dc2fa5a3a4b3335424fb8de77d38909406395a029b5da510aa5c9e1"
    sha256 cellar: :any, arm64_golden_gate: "70a400ed53804849597e691f79d55c722972eff9aaca4f6b474fcdc7794e4022"
    sha256 cellar: :any, arm64_tahoe:       "2ef96b49a2909cb2a975d2d39eaf0ce37643e8457fe526b84e0a0426782c68c1"
    sha256 cellar: :any, arm64_sequoia:     "530927161a58f7799e3f3a9cc3ebe9be4146f1c310a2dd52927ab957c1e5d203"
    sha256 cellar: :any, arm64_linux:       "539fb7b5d1d4533e6bd16b71c8bc853ec4afea81faf1e4c47ed8f8e1773d33a1"
    sha256 cellar: :any, x86_64_linux:      "716d74881f87eaf0edf989724c8e1c9edc1a192571540104fa7a6043817a08b6"
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
