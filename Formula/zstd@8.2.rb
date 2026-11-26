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
    manifest_sha256 "6a9c59e7f5beedd6ddf3ecc4c4316ce500b5928533eb974deed613871682c978"
    sha256 cellar: :any, arm64_golden_gate: "3ac647c0947ec5c7f063c90fde64b03b0958062a79b962a1ea1647d1dcc76dba"
    sha256 cellar: :any, arm64_tahoe:       "544c1a27078efacde96d209934ebc6c9f25d8806d800f9dddbd41d78f7762545"
    sha256 cellar: :any, arm64_sequoia:     "5866a6280c638084b7382077c5900df41e3840e7615960dd987fa7b5140fd7c6"
    sha256 cellar: :any, arm64_linux:       "254fe6c1bcc2dcd1841bbae4d06676c4621cdfc53118af7e907599686c2d42ad"
    sha256 cellar: :any, x86_64_linux:      "4b33ffb74bcf51289e0b4d949486bd9a0a3e78e35890b365d42d7da8b685762f"
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
