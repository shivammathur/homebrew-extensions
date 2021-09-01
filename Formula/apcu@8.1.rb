# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://github.com/shivammathur/apcu/archive/90279ca8fe062a8c595ceebac339a3e4c9a3ebab.tar.gz"
  sha256 "b0e3b1ede3fdc98d56d40952600405bb69ba23f3d39c2a6821af8be09b6110eb"
  version "5.1.20"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "307c89daf17a398f2e9775ae7d080a28717b0ec1c83e4bf36ca79cddecb67232"
    sha256 cellar: :any_skip_relocation, big_sur:       "0dfa615b01a158da71e1c02386a80292e2cf0380431bf47ebb1e5f412d595b92"
    sha256 cellar: :any_skip_relocation, catalina:      "dd6eab7d7499940e872c7381747ee411b7755d387803284fe92605a08aafec84"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d4022edb94b1e2f1ecf24c7aacb71d6ed41b4faefac738aac8552214a21ec0f"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
