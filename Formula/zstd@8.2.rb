# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT82 < AbstractPhpExtension
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
    manifest_sha256 "04ad1e37524c4b67b8f24202be605a0caa4622645806a7d091fc601f88753106"
    sha256 cellar: :any, arm64_golden_gate: "8ca447c2385291dbe84a82cd4461ae140ad0c349da9fb4c25d65bd079f5c1dc4"
    sha256 cellar: :any, arm64_tahoe:       "20f29ad18a9a2e7bbc519e1dfd9a94f9c6410c868011186ca431f6541bc9fd7b"
    sha256 cellar: :any, arm64_sequoia:     "1ce6d70a7ab93dae8918c5b54b13f5aa9c96c2307abd530c8e9213a66f744b93"
    sha256 cellar: :any, arm64_linux:       "649bfd2ad60a4964b451d8752265aa574fd73f09eb2d94a2ff44a4ab73db54fc"
    sha256 cellar: :any, x86_64_linux:      "8c5bf736561d87665252d65b767d30c1e2fe96e1d615a457f7abff592a9150c9"
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
