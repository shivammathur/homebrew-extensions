# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT81 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.1.tar.gz"
  sha256 "bfaf2ba7bdb11663bd9364096daa246fa4bfb1dec1eed9fa53ed9a8d5ed1f647"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9ae51388d54e9d305d8d288605413819c81917854a6f94dff4ae8ded6f88deda"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ec1624d910d502f1a0dbff7b0530fd2044ac1dcc3a13ee474b78a170318ef369"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "94592ae178396066180dc10d23b33581fe03aa6a12f0c355e12d548b58e57232"
    sha256 cellar: :any_skip_relocation, ventura:       "c0bce14259dc64c738a8a17d8c4ab0c25f709b3e4500d0c3526574f2a5ad50a1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6f699b693a7517b6e9da783628d049a2c779e5c798589899dd86a3c3d18bd7e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2a15a87d598a3137712a56e11f572319e1134cfc73ba26adcb2b8e668bc9b68"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
