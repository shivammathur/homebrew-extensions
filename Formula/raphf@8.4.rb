# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT84 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4282a7403d67a0074ac29a530cf520f0e91bf7cfd249a27c51b47911d8964f64"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3ac8f8f5284e88ead5fbd80c5c9b3e0acb36b3a30335855770177e2841839f43"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ec70ed16e45a438719f9528bcd36665c18f9cda5e73681b9124a9de4ea0abfc0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "151c414449f314a3ac337265fd72fd31b06714f30b0577cb6987dcb80b48badd"
    sha256 cellar: :any_skip_relocation, sonoma:        "720d8fbf039731cbd9a8fbad55b3811a877283b262e2b12fdc05cff27b46bcdc"
    sha256 cellar: :any_skip_relocation, ventura:       "56c8cdbc52cad8f10085a0960923e199954f2022ea4e66acdfc2429100659da2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9a3c3b746716b9366201b8fd392b3344d8025fb2e5e93f8e063b0daed8344ffa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9c7a989986b5265d6a181b74a5d36bdb51e1c353d5d36e66ef57c302ee6a858"
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
