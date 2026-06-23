# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "3dbfbce7d430e06b9ea1d4295e5daae5e5bbf2766cc3cc7f47c9c796b2b1e602"
    sha256 cellar: :any, arm64_sequoia: "007efc8aef234cd3bd755680c51a1e5ba65742ce3e58df3d893e29b47c5519fd"
    sha256 cellar: :any, arm64_sonoma:  "a373e48e2d89fe4d46716c5de368ebbf69e976067594ebbfc5f1ba332e19a69f"
    sha256 cellar: :any, sonoma:        "f4eebda7920fe652370aacf92d8cc7b2fcdb71d9fc23e8e6811c63593fabaaa3"
    sha256 cellar: :any, arm64_linux:   "3a4b86f14ee584462a199b8ed528bea464b764f90adaa3f94e2dc7ecc8c3ce2a"
    sha256 cellar: :any, x86_64_linux:  "282f9cb04d915f5a324a7fc04259e382947dc12c7953b0dc3a1b4688ee592fdc"
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
