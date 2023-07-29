# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT83 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4b475d9856146224bcd6d1c2219a5ece83984b78b988cf9f68b3107a7566d91b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "03ec0c97595d2337914a77a2e4a5db8ded7501db3c18945d01b80191c263c297"
    sha256 cellar: :any_skip_relocation, ventura:        "e0ed31e4deae1437c9d80335d3be76d45e16d0bc571cb5d5a0003d00fd207bd5"
    sha256 cellar: :any_skip_relocation, monterey:       "f9a2fb4ea3e0a864985aa17bdc078e92328ea29f9acea8c4f039515dc102fb20"
    sha256 cellar: :any_skip_relocation, big_sur:        "3e3a4e3160b6d8e287a70ea34032df4b33ee3fa70ef33fcce22349c4205c38d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3164d4fc18ddbd26d57dff3f042803a36c127d1f236e339ef802d07fb7600029"
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
