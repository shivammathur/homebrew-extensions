# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT71 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "f37005261413776eed4d8267ca765fca498e3867c781f689a1105f3b26e58550"
    sha256 cellar: :any, arm64_sequoia: "5dc514b4f27566aa910d9a473171d3cdc857c72bd6ac228edeba10d0970d8d96"
    sha256 cellar: :any, arm64_sonoma:  "7a52bae5986ddbd650477322b91579eda9bbb0d54d7d23be486ea87ae62bdbea"
    sha256 cellar: :any, sonoma:        "dd2e772dafbf18ee693c0414ddf8f01a5a09f66db6704444bc86126e756013fd"
    sha256 cellar: :any, arm64_linux:   "0d74948ce4271a4877412f5f76af0b599ed8e67178481c7d5aec79d9620bb7b0"
    sha256 cellar: :any, x86_64_linux:  "f4f32566ccf01fc35174cfc08589e8454ef50540c75e5c6aa0c9e82cfc9d74b2"
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
