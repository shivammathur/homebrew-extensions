# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT81 < AbstractPhpExtension
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
    manifest_sha256 "f8bbf51f55042ece4e8eda36e6b46e7ebafe19c31a703e0081e3b2f4ac8b4422"
    sha256 cellar: :any, arm64_golden_gate: "b7ad95a825668872fca8cc0a391850526ee13b9d670783848729f908dba02ca6"
    sha256 cellar: :any, arm64_tahoe:       "4bb4ec9abb8d199c7e0e8f9c9ebe41b6c278d50ce630ab05f616ef4e2a7d6ba8"
    sha256 cellar: :any, arm64_sequoia:     "990387942bb67fef31d88553bd0a5203f06f0ea223e366920a418b3c3dd89313"
    sha256 cellar: :any, arm64_linux:       "3931ce2ccd65779c4acd48add6c893ec72085e356346e9c78fd62bc45cc164c8"
    sha256 cellar: :any, x86_64_linux:      "e9050d6755170c747b07c97096e9ada9634f44375273977d57bf0dd0388933c5"
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
