# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT73 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.19.0.tgz"
  sha256 "27d406ba894015352e305c8b557812ffd70b3899b6a519ab874c99e42675cd3a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "be4b0f8ab9210d25f7ef0f960dc6f31b203632a1baecb034626a0d79394c96e7"
    sha256 cellar: :any, arm64_sequoia: "67c15de057c28f0d1cd18ee542a06f419d0aa0d8ce1d060ec5e9bd90dd332419"
    sha256 cellar: :any, arm64_sonoma:  "1a32fc16210888a2388d977576d577a123eb5e320c5feeb1570269635dac03aa"
    sha256 cellar: :any, sonoma:        "4ee48003e41654f956e84d5eadcc88b4670237836860f3b5d64fd81d53c84a89"
    sha256 cellar: :any, arm64_linux:   "e45688c41d940506e7c4e2a54ecb16256db4693479c5823b1da1803fb383ec1c"
    sha256 cellar: :any, x86_64_linux:  "d584ce0c68b875f514b10899fbb7e154992693cff66b475c8c2fad2cff03a3f7"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
