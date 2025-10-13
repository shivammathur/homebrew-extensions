# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "62d5bc293e507d6c6d4d92cd438053afec329495a4c41ff958ed1b2b854b710c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "03eab6a4bd947ed5874c6341b6c1cc1fbb07b5eb31b0580a4e716511ebaa2830"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1bf6f1ce5230c84de71bca6d9d86a275f8a8fdaca15b88cd77b4855f70e40fc9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dd4798c36486e1b6874e5c83354e450b81a30de073bbd9f871f46b79d690b2ec"
    sha256 cellar: :any_skip_relocation, sonoma:        "067a8f31335d42539e249a6aa58b6c6d346c3099dfc037623c169d8023159667"
    sha256 cellar: :any_skip_relocation, ventura:       "4fc81b46c7d3b42578c5ed0782a72f35dd1ecc994754a8c8beb8c7bde6990586"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7f929aca1a52e0d90a6473e3d22ca731b95d6c840d0863c1d48323215998d5ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5fafc9c167df59d2b322c6da956c0b93881aa15643c4a612d57981b16f74a94a"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
