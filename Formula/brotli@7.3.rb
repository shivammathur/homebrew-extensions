# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT73 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.18.3.tgz"
  sha256 "ed3879ec9858dd42edb34db864af5fb07139b256714eb86f8cf12b9a6221841a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e5014cec81c96c5d383a7603dad2b6519981e78b01bb869834e680850f3b9d1e"
    sha256 cellar: :any,                 arm64_sequoia: "3d666fe492c26f6f2fa01cc5b2a125c57e72d4cd293a6ca22287d668a460776f"
    sha256 cellar: :any,                 arm64_sonoma:  "7c9c0530e41b98d1c9b4a65fd91541ddfb65cce66dbb5c691a373313cd22d751"
    sha256 cellar: :any,                 sonoma:        "d25df9045a7df7c02d4479a54e5f776633549d8072516677251c8d6cdf39e60a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "12d0ccf937bfae0322eb15a82bcd065dd0076816e3f0b8f3fa75bebf264b48bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "da7404577b1cbb651008218a9425b0e85cc70315308b5a6a377614c2428a1dac"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Formula["brotli"].opt_prefix}
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
