# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT80 < AbstractPhpExtension
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
    manifest_sha256 "892c50599b75af080ad247e95eb6832f970f9296627ccc3a03d82f26c05302a3"
    sha256 cellar: :any, arm64_golden_gate: "54534149b7536a64c84194042cb59c5f0a3e87a9dea71353801e815fc851931e"
    sha256 cellar: :any, arm64_tahoe:       "3b493d3c01f0ef9555f1b1c9e880a48e3e597d6cfe80867addf23af5ddbb5c04"
    sha256 cellar: :any, arm64_sequoia:     "4ede8ac33519dc4f72663e8cce41120f17dd92c3fe26fd510ba06722e6ae6b78"
    sha256 cellar: :any, arm64_linux:       "82dc2d168ff88d4a267093159b6640d17f10005a0d5038180df981cc14114071"
    sha256 cellar: :any, x86_64_linux:      "f908ec4392ecd7a1508d03bec95a6df45408ddba461515d2fbbb8a1459963de8"
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
