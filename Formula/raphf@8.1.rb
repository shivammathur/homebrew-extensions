# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT81 < AbstractPhpExtension
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
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "60e3857e09dd551130305cb622770cd64470bbf525c41646f5ffe328a8c35401"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "5fef47606d7649f201b3e7660e697b9e8e5ff373d4f6675eb9eae54543154b0a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a3c8a5fda590738cf97e8e6b9dc672b549f59e1a0718e6ca12fd0a2530e8c2f6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b2f5cd0239b0a9163b1cecf589f1505ebe4a50605cbd0a070f14d0c336c44b14"
    sha256 cellar: :any_skip_relocation, ventura:        "04f247873bcc877eddd01780d696c88f44f9871a9c492cc77b52005acd0d40cf"
    sha256 cellar: :any_skip_relocation, monterey:       "37ae16098912c57d8d1782f6da535a92173d7ad36e634261b08a02b22d141909"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "4619f324f5772829352ac5d2e104a3d9c9af856b6352774186cb60f34fe1d2ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f9cd4506817a42a0421096228a88b8153f0d308497cfd31ee8dd390c10b190e8"
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
