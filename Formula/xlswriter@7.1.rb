# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.2.tgz"
  sha256 "a85ce71f02eafb2617ab125b8c97677ec8b4eab3cd81f32478a5eb44fe55f145"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f80179da1bc14f7b3b3c3aea4d649bfb40d1dcc4326bbe8cd7add0fc5f93617b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "18653e9437ce93eef2fc5ccb0e49056521c13cdd0d6c035a94dcbee499f09fe6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c3b23d1128f25a4ad98da43137bd1d8da78c61b9d6c3c5925f041b17f2b4f018"
    sha256 cellar: :any_skip_relocation, sonoma:        "a35300dedd249e704bf8d2c0132107fa74a290f64af1dce82ea850d1c23a31b1"
    sha256 cellar: :any,                 arm64_linux:   "46108c0956294eb6daac62f94a46cbbb8e245155e0b2664e419a1d3fa5dc6f28"
    sha256 cellar: :any,                 x86_64_linux:  "7f82fc5bc284a6a3b3c873142b47df0218fd9c3a5f68f54f9b28cd98ed8967a6"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
