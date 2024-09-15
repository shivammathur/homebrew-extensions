# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT82 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "2b71077347b65c21f2dadb9e92cd1fd4ee714d6d82c91e5d877e4ec516906efd"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "77ee224f5d4dc609534b4871335c2fe92a0bfa55da2994cc2ac5936057f85963"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8898b35621bdd0034fa1b496fa20d915c4b3e34c0a7c91e2f2b43602e5a23e07"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "60c7d4e17d4727b664183a9073d15ffedf166cb7e76f4b057b059e381f9bcb9a"
    sha256 cellar: :any_skip_relocation, ventura:        "6c94c3d2e7b319e4a55b20df9d6e7d85a8cacdaf82f04b9ad95710b0dcccc601"
    sha256 cellar: :any_skip_relocation, monterey:       "12d124c177fba923bee9ddc478b06cb08119516367dcfb5b18fb5f0be3952141"
    sha256 cellar: :any_skip_relocation, big_sur:        "965667a712768b3acc14916cd8b0476e5b2cb0c483ab7837f9c9a22abd65a01a"
    sha256 cellar: :any_skip_relocation, catalina:       "1a3e701f44754dc2a010b537e621f436ef9e529148a6f7cc9aea040e11815a93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa588c65816f7613485e0434d5e1f914aa17cd4422ba13b72f82cd6125561d2d"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
