# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2578b44233761f2a088c0099729e0cd67a7d9dce537654f079f4839e4f803859"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9404fa4f08d7257b5dc8b49624838d191446f40057d656df417242d4ade577df"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0573a7d12f90886143524925900cda5b09d09416a7417a28a448c5fb25754767"
    sha256 cellar: :any_skip_relocation, ventura:       "faf78ee51b62cc24ed54cb81767304ba7639ba602f7321d7c191e5b1390bb4fa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d0e7249ee2235832e5e761e21d7e5b39a4bb685ef06e7da20ee8b74ab45b8830"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d042bbd98612117c5ce389ff8ce944f51153025af8045d52199957ee5b54877"
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
