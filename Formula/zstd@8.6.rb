# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT86 < AbstractPhpExtension
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
    manifest_sha256 "bcde1ff229f5da14a5bb8828766fe661d9bccb3cbb1f2fe64df73a71215d361c"
    sha256 cellar: :any, arm64_golden_gate: "72a53784fde60df1f201accd3c41c682bc699a85510f08e58a92c1905fe348a8"
    sha256 cellar: :any, arm64_tahoe:       "0a0c5b22d10544f6202c2aa680f59e2224bed13219dcb3d10a49bb30705b7365"
    sha256 cellar: :any, arm64_sequoia:     "c83742ea98eca66ab60c06e5469b65ee036cd717a8c0debcaa8e183a9460eef9"
    sha256 cellar: :any, arm64_linux:       "b665c400eb8e40d9e248e03405a489c86b0eb5e4b997d146059b0eee87d3e716"
    sha256 cellar: :any, x86_64_linux:      "19d6e1af2ce0b4a213478ebe5ce5e0885ff4218a37909afb29816fbd3bcfaf0d"
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
