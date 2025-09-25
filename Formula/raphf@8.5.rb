# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT85 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  revision 1
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4cfcb19182c55b4190d1e22d7a3942c19be31b502fbe12c0fd8906ba37017223"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dfc2f68809852e25625aba917187fa4a941816a8b70ef70b65811aa45f44e6ff"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b821f156cf895082bec0f09ef9b414f5a04d3bd49454488902c0f322f5f2e782"
    sha256 cellar: :any_skip_relocation, ventura:       "21171626a3a81f2af3abf0e4b9a0f0b5f0e3534253b8068d6a1dbadec9b8e2dd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "de55af385074a35760043f9310d32c9f48065de5a93dae9ab1d3b79db353f289"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8ed8c69a84cdb8c131ad18de1661d31779756e392deeab68ba156b8b8e507519"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
