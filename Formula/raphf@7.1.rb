# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "44b5fc4592a1daae2b248ae578d4ab21803c7178bbbf6ca8ad6e05b22de4c355"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b36df88c5a1dd3c9ba26333c2ac29e9632109f0d84d1a08246b84e9e0dc4d8a7"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "256552669aecf8f20727a6eac150ee90e3a69f2c98404adc635ace04a1ae9097"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4d547571d08c1cc1894aac013926e5bbe729c1c9dbe6d98a02dea8ac73629bec"
    sha256 cellar: :any_skip_relocation, ventura:        "cfb02fa56369ff50ffe12befd7549bb8254448272365e68c90f272097eb6771e"
    sha256 cellar: :any_skip_relocation, monterey:       "a4c88aebdd407270b7c2385548bd348735edefbf57d73003caa444be0a998eec"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "508169473ea646ed55d3a0584912b5b8576bc8b75a61f979c1a5048d24bd76b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f05bdcf64a1d89042a3d147fc59becc35f24f1c82a9b431ca915beb854c1ba1d"
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
