# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT80 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "73118b76a9cb8b46f1a11bb852543f033a9f90e417ee8789c6f25e2072ccefbc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c2a63fdc8a3ec8b552749d56e4305b80e881cf50ed765e63da035b532a9e8022"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a32028cbe5c18e43637513e55d98c1b60e7f9ad5f9d2d02a84248c8be97c3e92"
    sha256 cellar: :any_skip_relocation, ventura:       "87573dbc7eb19362cf11f587967907ad5eb5d8e791539f9c03ec12067a6a6932"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f5e62e853321edfad2182d5426f3a271a1e4899a1ee6e2e4558a207e42e4d210"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b780eee9b23eafdcbd59d79948786b52d232ca48995a4b3f99589c3d67f9323"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
