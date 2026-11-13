# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT87 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  revision 2
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "df3ced341f96d8576426a0673d515dbc0c4274564d0bbde4e4cc7acd3f19960c"
    sha256 cellar: :any, arm64_tahoe:       "2ea1cb84a20b736ded290cedb4f3536bb0f01cc81ba6fda6803b0f5f782f34d1"
    sha256 cellar: :any, arm64_sequoia:     "86828b7b84dc5f604166a57814d191db11f8ebe0de58f47b8024813ad8a844ea"
    sha256 cellar: :any, arm64_linux:       "6f0946e2b0c57ac5a0f364b29168cca986c2905bd25b21c8d6c424e32fc7f698"
    sha256 cellar: :any, x86_64_linux:      "cdaaf28485c160b48168c3918e246636d1c5454f3b0055a025bae84f7838c6ab"
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
