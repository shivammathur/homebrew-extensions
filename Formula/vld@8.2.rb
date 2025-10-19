# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b4e49eb5af3a713227da39161e483fe355e0bbd1c218cd01815e23057e60ac69"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e4b33484a05311119a6caac686aae8a4ee37957d6c7a02606f7393862bccd60d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2e454d1a374c443c429813215957929aff238f536a00967fdce54ee8fc611c07"
    sha256 cellar: :any_skip_relocation, sonoma:        "c99368b09a1d1c3a03f5d21d7c1491791fee5df824a0fafca537d300ba7c4920"
    sha256 cellar: :any_skip_relocation, ventura:       "d71f48f529c03ff4e9fd35e23eabe3146f6d771997d39ae413d7d74844b54a18"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "303c30e613f15acbfcc784493577a8b34bfac97101fb02b4376e7e2086a3b940"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bfe4302cde32f6731851ecb268139237a03eb6abe6a3522b52a6ea2966c3358b"
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
