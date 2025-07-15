# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a34fa8ce0855719f56ce805d296ef0f482ce72375ec73c6c9523e5ae5a23a458"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6612eac75f050c9efbd7e44b6ac33a62a7c9c040c4e73491d51674d422834258"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5b3904e9fa1c6780824e6753a634289e3426d83a30c3a0f233c434b295fb642c"
    sha256 cellar: :any_skip_relocation, ventura:       "1167d4ab64d71140ab318852d41b41ef1c641bf8933eae058fb370f0c92c3d74"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bd91fa74c3cac1a0cf56c1711278c445fae7b1db7dc01df7ed16f46fe7b81f1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "804646fee16686515961345db3ccc9d0a2d74d1c419d1f4398aa0438f57eff15"
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
