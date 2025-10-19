# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e76bb902223dfa6870c9a724bcb7b9405cafc5da804a3eb1605a09151cbde962"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3decde8469bac224275df32a7988b7a07d4c85198275428cc93fed004709fd83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5bda1df40f261110438ed13d9f55efce916bd5092969791dc26dd3b3da1b3bc9"
    sha256 cellar: :any_skip_relocation, sonoma:        "3400759f64c78354daf6aed59573a1a3ea4092582bf82193ab7cdb1b3159744e"
    sha256 cellar: :any_skip_relocation, ventura:       "35baae913c9d145b1238003bb3d2bbb1cd581274fd7e273019f7b2287d59855b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ca6afaef0346e6545498736ca3a942125fa7c1303a05e2c973a7ef87c20bec2f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a2d9fe993ecd89abecc7c55ea2a61ca4c92ac57490d978e7e306743988088b08"
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
