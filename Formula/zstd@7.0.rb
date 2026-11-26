# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT70 < AbstractPhpExtension
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
    manifest_sha256 "f9ef0b07c06302e3d0cfd4153c9d84b556e3d18c34be098efee8bb57f21f05d7"
    sha256 cellar: :any, arm64_golden_gate: "7aa123e6c9cc4fdeaf7ac1b587af439e536e9dc36c6924680d760bdde195d6e5"
    sha256 cellar: :any, arm64_tahoe:       "542dde67ac8365bdfb1db337d891c43b8055d6a82c18b86e14d97be6a17c9eca"
    sha256 cellar: :any, arm64_sequoia:     "e2b8fdb7161f4e090808012fd83a540efcb070ba1c4635ff43b4c73d249035ab"
    sha256 cellar: :any, arm64_linux:       "6b0b68088e81c09e65d95d4d435c01cd371cbd69b059a44139b3b2efa48b76ad"
    sha256 cellar: :any, x86_64_linux:      "02aea6185dbac56dd0c2bcd68c074b7f85b00a267f6a25ff3d441c5f4e730fcd"
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
