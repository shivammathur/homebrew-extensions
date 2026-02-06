# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "641a0e56988d1867f62bb9f7502daaf2e0654fad2e4a9481d09fc20714c28ef7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f1c5b734fd445b15866589ce19c67930c95918907d9551dc511e0e056c433129"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cdc3c0d7148da17ea0afe25a583e6a89736b7f19589a73d9bd51d07fec0644ed"
    sha256 cellar: :any_skip_relocation, sonoma:        "636ed8c3ec327303021ec0272473892085647aa851b361e1e33d18721501caea"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3704370df92e82a04a45550a23730c0b952ab6f753a5688b0df6036545be9ce7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a4d5df6b1432d504f07e34f25321478e4221d15294cf3db7978c9862dca5852"
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
