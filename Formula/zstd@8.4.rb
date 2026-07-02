# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT84 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.17.0.tgz"
  sha256 "38cf9e239e72e775bdf01fb5f1abaed76c7ce92e8d3a562a97ef96c9d0446ea0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "aca9b3165964af5367fc064dfdecb8501a7e2cdeec72b807b5ed89bc16c5105c"
    sha256 cellar: :any, arm64_sequoia: "92926b7acbfae1abb94ef26c1f12f3c09ee3869075c8de51d6e3c74c0fd2518a"
    sha256 cellar: :any, arm64_sonoma:  "c152b3ecf93c2f3f02cf7f49ca97c7669616da9cd85350c545c58deba62eb5f0"
    sha256 cellar: :any, sonoma:        "2c33daebc5dff2c4ce26a1a4a5ec17f45370329fb99c28bd1fc4815bdf432bc2"
    sha256 cellar: :any, arm64_linux:   "6e5cfc04d61de76802f9860bcadc9a689f92c5d18ea2c72f3fad0a98618ccbd3"
    sha256 cellar: :any, x86_64_linux:  "84998ed644f9795737629a6e630ff210c59bd5799de7172e3bff674b89510399"
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
