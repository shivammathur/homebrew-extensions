# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT82 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.5.tgz"
  sha256 "cf49acd81a918ea80af7be4c8085746b4b17ffe30df3421edd191f0919a46d1d"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c23379d2eea895cd71c0703e2fa772a94a8f701ed88c8960b0dbf627f5913d0b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2202cc86edf86934d3756de0246eef511cd90b4545482f4679c06275eff279d7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9ddb171bd912b9fa2d34cdf32cde77855a99087e8bf7033a85856acaefd495b1"
    sha256 cellar: :any_skip_relocation, sonoma:        "f3da61047a79ebe68a03ed5dc50e533e2f9f1570e58f42e7ed4860a78615dfa0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fbcda5a4d1ecbe4e8659a1a8b391a26a7b6e457a5bf0fe8fcdcfef4de122a62f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b13b812f2a02455766ae057c88bfece5cf9c43d52ca5f44188c231a48ae8c8c2"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
