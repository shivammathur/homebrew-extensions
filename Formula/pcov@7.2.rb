# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT72 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.9.tar.gz"
  sha256 "c4c2a1de8e546c00eab8bd2a666028c25d16b8d76829e43280b742ae60e78f85"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "91009e398369f46a301006c7577342c058a2e07ddaf65237d1d7f76c28bf18de"
    sha256 cellar: :any_skip_relocation, big_sur:       "cc668e91aada5789b19341da88674826dcf8c6cbd67b67823847a88deb141949"
    sha256 cellar: :any_skip_relocation, catalina:      "409ff3a80c704205cdeb34d37c689a2119d302246807c7cf081ab943c016ce33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ce1f1261c6e823be091c13f00a8a7d4550bbe371005a1b7fe86812024909865e"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
