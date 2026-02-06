# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Seaslog Extension
class SeaslogAT56 < AbstractPhpExtension
  init
  desc "Seaslog PHP extension"
  homepage "https://github.com/SeasX/SeasLog"
  url "https://pecl.php.net/get/SeasLog-2.2.0.tgz"
  sha256 "e40a1067075b1e0bcdfd5ff98647b9f83f502eb6b2a3d89e67b067704ea127da"
  head "https://github.com/SeasX/SeasLog.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/seaslog/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1d5c0265fc24e6b0552e7f6c46820b854ec5def5b30ccf56b52865d44b353536"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4d1ee23deaa7876c6ff7a93809944178ce27ee00ee7b97a226fcb3e0907d3338"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9c8f1762137a7c3bfb78ed7339f76fd0c76dcf2dd995d4a232bbc065d93f7423"
    sha256 cellar: :any_skip_relocation, sonoma:        "15ae3fc86231b62fdbf4c3cebdfd5eb20eb0adcba590798b6f0a8b606065df7f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e4a4514d2f2e2cc8e1d9875dacb5604ce3bb75a0a2b1c14ac64d53c78ed9951b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "315312c0f9b9a7ab5288c5800763d7083e181ce66df02cdc4dc99d6a972da8ac"
  end

  def install
    Dir.chdir "SeasLog-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-seaslog"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
