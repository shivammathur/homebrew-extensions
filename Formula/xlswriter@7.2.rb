# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.1.tgz"
  sha256 "279749cbe22858af2f69958eeefea3060a2e6545fda1f8fc0fceba0a44f29a20"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "088dea486d16741123fd26615340e56f77fd9521a63f3ccae2e1aa2c3483985f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "47e87e79860ee8906454024a67e0048f004e1308f6e1afa40bd40927dfcc88ae"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0d107c6ce9907dcbd744724316ead5e62297fcc71bdacfec6af141ea3752b10f"
    sha256 cellar: :any_skip_relocation, sonoma:        "9c99fe176630c2e121f8e12e43678d9138eb67fae76c46cc91d0d220ec162d41"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ad1b598d197bc0c6a82c7983da6cd58ca1000345be5760a3409f3e985ddff922"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "732afbf26a5f65dbe8934b1713012ef8adcd768513049c6620b0f88dfefad356"
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
